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
+	mkdir -p debian/libgcc1-frc2019-armel-cross/${PREFIX}
+	mkdir -p debian/libgcc-dev-frc2019-armel-cross/${PREFIX}
+	cp libgcc1/* debian/libgcc1-frc2019-armel-cross/${PREFIX} -r
+	cp libgcc-dev/* debian/libgcc-dev-frc2019-armel-cross/${PREFIX} -r
+
