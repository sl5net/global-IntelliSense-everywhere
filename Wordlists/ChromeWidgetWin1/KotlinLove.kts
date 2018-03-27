import java.io.File
 val folders = File("c:").listFiles { file -> file.isDirectory() }
 folders?.forEach { folder -> println(folder) }