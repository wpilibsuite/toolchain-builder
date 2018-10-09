Description: Makefile
 add makefile
 .
 roborio-sysroot (1.0-1) UNRELEASED; urgency=low
 .
   * Initial release with 2.17-r4 and 3.2.35-rt52
Author: Patrick Plenefisch <phplenefisch@wpi.edu>

---

--- /dev/null
+++ roborio-sysroot-1.0/Makefile
@@ -0,0 +1,8 @@
+all:
+clean:
+# all and clean targets need to be present for DESTDIR to work...
+install:
+	mkdir -p debian/libstdc++6-frc2019-armel-cross/${PREFIX}
+	mkdir -p debian/libstdc++6-dev-frc2019-armel-cross/${PREFIX}
+	cp libstdc++6/* debian/libstdc++6-frc2019-armel-cross/${PREFIX} -r
+	cp libstdc++6-dev/* debian/libstdc++6-dev-frc2019-armel-cross/${PREFIX} -r
+
