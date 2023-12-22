# Copyright (c) 2023, [RuHor]
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


import sys
import requests
from bs4 import BeautifulSoup
from PyQt5.QtWidgets import QApplication, QMainWindow, QWidget, QVBoxLayout, QTableWidget, QTableWidgetItem, QComboBox, QPushButton, QLabel, QHBoxLayout
from PyQt5.QtCore import Qt, QUrl
from PyQt5.QtGui import QDesktopServices


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()

        self.initUI()

    def initUI(self):
        self.setWindowTitle("Windows Builds")
        self.setGeometry(100, 100, 940, 600)

        central_widget = QWidget(self)
        self.setCentralWidget(central_widget)

        layout = QVBoxLayout()
        central_widget.setLayout(layout)

        self.version_combo = QComboBox(self)
        self.version_combo.setFixedHeight(25)
        self.version_combo.addItems(["Windows 11", "Windows 10"])
        layout.addWidget(self.version_combo)

        self.fetch_button = QPushButton("Revisar", self)
        self.fetch_button.setFixedHeight(35)
        layout.addWidget(self.fetch_button)

        self.result_table = QTableWidget(self)
        layout.addWidget(self.result_table)        

        self.result_table.setColumnCount(3)
        self.result_table.setHorizontalHeaderLabels(["Fecha", "KB y Build", "Enlace"])
        
        self.result_table.setColumnWidth(0, 200)
        self.result_table.setColumnWidth(1, 300)
        self.result_table.setColumnWidth(2, 100)

        self.fetch_button.clicked.connect(self.get_builds_info)
        
        self.link_label = QLabel("RuHor Software Solutions GitHub")
        self.link_label.setAlignment(Qt.AlignCenter)
        self.link_label.setOpenExternalLinks(True)        

        self.link_label.setText('<a href="https://github.com/RuHor">RuHor Software Solutions GitHub</a>')
        self.link_label.setOpenExternalLinks(True)

        self.link_label.linkActivated.connect(lambda link: QDesktopServices.openUrl(QUrl(link)))

        bottom_layout = QHBoxLayout()
        bottom_layout.addWidget(self.link_label)
        layout.addLayout(bottom_layout)

    def get_builds_info(self):
        self.result_table.setRowCount(0)
        selected_version = self.version_combo.currentText()
        
        if selected_version == "Windows 11":
            url = "https://support.microsoft.com/en-us/help/5031682"       
        elif selected_version == "Windows 10":
            url = "https://support.microsoft.com/en-us/help/5018682"        
        else:
            url = ""

        try:
            if url:
                response = requests.get(url)
                response.raise_for_status()

                soup = BeautifulSoup(response.text, 'html.parser')
                results = []
                
                build_elements = soup.find_all(string=lambda text: "OS Build" in text)

                for element in build_elements:
                    parts = element.strip().split("—")
                    if len(parts) == 2:
                        date, kb_build = parts[0].strip(), parts[1].strip()

                        link = element.find_previous('a')['href'] if element.find_previous('a') else ""

                        results.append((date, kb_build, "https://support.microsoft.com" + link))

                if results:
                    self.result_table.setRowCount(len(results))

                    for row, (date, kb_build, link) in enumerate(results):
                        self.result_table.setItem(row, 0, QTableWidgetItem(date))
                        self.result_table.setItem(row, 1, QTableWidgetItem(kb_build))
                        self.result_table.setItem(row, 2, QTableWidgetItem(link))

                        self.result_table.item(row, 2).setFlags(self.result_table.item(row, 2).flags() | 2)
                    
                    self.result_table.resizeColumnsToContents()

                else:
                    self.result_table.setRowCount(1)
                    self.result_table.setItem(0, 0, QTableWidgetItem("No se encontraron resultados."))
            else:
                self.result_table.setRowCount(1)
                self.result_table.setItem(0, 0, QTableWidgetItem("URL no válida."))

        except Exception as e:
            print(f"Error al obtener información: {e}")
            self.result_table.setRowCount(1)
            self.result_table.setItem(0, 0, QTableWidgetItem("Error al obtener información."))

if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec_())
