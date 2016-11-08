import 'package:objectivist/objectivist.dart';
import 'package:test/test.dart';

void main() {
  group('VStatement', () {
    group('toSource', () {
      test('returns the correct value when w is null', () {
        final statement = new VStatement(1.0, 2.0, 3.0, null);

        expect(statement.toSource(), equals('v 1.0 2.0 3.0'));
      });

      test('returns the correct value when w is not null', () {
        final statement = new VStatement(1.0, 2.0, 3.0, 4.0);

        expect(statement.toSource(), equals('v 1.0 2.0 3.0 4.0'));
      });
    });
  });

  group('VtStatement', () {
    group('toSource', () {
      test('returns the correct value when v and w are null', () {
        final statement = new VtStatement(1.0, null, null);

        expect(statement.toSource(), equals('vt 1.0'));
      });

      test('returns the correct value when v is not null and w is null', () {
        final statement = new VtStatement(1.0, 2.0, null);

        expect(statement.toSource(), equals('vt 1.0 2.0'));
      });

      test('returns the correct value when v and w are not null', () {
        final statement = new VtStatement(1.0, 2.0, 3.0);

        expect(statement.toSource(), equals('vt 1.0 2.0 3.0'));
      });
    });
  });

  group('VnStatement', () {
    test('toSource returns the correct value', () {
      final statement = new VnStatement(1.0, 2.0, 3.0);

      expect(statement.toSource(), equals('vn 1.0 2.0 3.0'));
    });
  });

  group('VpStatement', () {
    group('toSource', () {
      test('returns the correct value when v and w are null', () {
        final statement = new VpStatement(1.0, null, null);

        expect(statement.toSource(), equals('vp 1.0'));
      });

      test('returns the correct value when v is not null and w is null', () {
        final statement = new VpStatement(1.0, 2.0, null);

        expect(statement.toSource(), equals('vp 1.0 2.0'));
      });

      test('returns the correct value when v and w are not null', () {
        final statement = new VpStatement(1.0, 2.0, 3.0);

        expect(statement.toSource(), equals('vp 1.0 2.0 3.0'));
      });
    });
  });

  group('CstypeStatement', () {
    group('toSource', () {
      test('returns the correct value with type basisMatrix not ratial', () {
        final statement = new CstypeStatement(CSType.basisMatrix);

        expect(statement.toSource(), equals('cstype bmatrix'));
      });

      test('returns the correct value with type basisMatrix ratial', () {
        final statement = new CstypeStatement(CSType.basisMatrix, isRational: true);

        expect(statement.toSource(), equals('cstype rat bmatrix'));
      });

      test('returns the correct value with type bezier not ratial', () {
        final statement = new CstypeStatement(CSType.bezier);

        expect(statement.toSource(), equals('cstype bezier'));
      });

      test('returns the correct value with type bezier ratial', () {
        final statement = new CstypeStatement(CSType.bezier, isRational: true);

        expect(statement.toSource(), equals('cstype rat bezier'));
      });

      test('returns the correct value with type bSpline not ratial', () {
        final statement = new CstypeStatement(CSType.bSpline);

        expect(statement.toSource(), equals('cstype bspline'));
      });

      test('returns the correct value with type bSpline ratial', () {
        final statement = new CstypeStatement(CSType.bSpline, isRational: true);

        expect(statement.toSource(), equals('cstype rat bspline'));
      });

      test('returns the correct value with type cardinal not ratial', () {
        final statement = new CstypeStatement(CSType.cardinal);

        expect(statement.toSource(), equals('cstype cardinal'));
      });

      test('returns the correct value with type cardinal ratial', () {
        final statement = new CstypeStatement(CSType.cardinal, isRational: true);

        expect(statement.toSource(), equals('cstype rat cardinal'));
      });

      test('returns the correct value with type taylor not ratial', () {
        final statement = new CstypeStatement(CSType.taylor);

        expect(statement.toSource(), equals('cstype taylor'));
      });

      test('returns the correct value with type taylor ratial', () {
        final statement = new CstypeStatement(CSType.taylor, isRational: true);

        expect(statement.toSource(), equals('cstype rat taylor'));
      });
    });
  });

  group('DegStatement', () {
    group('toSource', () {
      test('returns the correct value when the v degree is null', () {
        final statement = new DegStatement(3, null);

        expect(statement.toSource(), equals('deg 3'));
      });

      test('returns the correct value when the v degree is not null', () {
        final statement = new DegStatement(3, 2);

        expect(statement.toSource(), equals('deg 3 2'));
      });
    });
  });

  group('BmatStatement', () {
    group('toSource', () {
      test('returns the correct value for parameter direction u', () {
        final statement = new BmatStatement(ParameterDirection.u, [1.0, 2.0, 3.0, 4.0]);

        expect(statement.toSource(), equals('bmat u 1.0 2.0 3.0 4.0'));
      });

      test('returns the correct value for parameter direction v', () {
        final statement = new BmatStatement(ParameterDirection.v, [1.0, 2.0, 3.0, 4.0]);

        expect(statement.toSource(), equals('bmat v 1.0 2.0 3.0 4.0'));
      });
    });
  });

  group('StepStatement', () {
    test('toSource', () {
      test('returns the correct value when the v step is null', () {
        final statement = new StepStatement(3, null);

        expect(statement.toSource(), equals('step 3'));
      });

      test('returns the correct value when the v step is not null', () {
        final statement = new StepStatement(3, 2);

        expect(statement.toSource(), equals('step 3 2'));
      });
    });
  });

  group('PStatement', () {
    test('toSource returns the correct value', () {
      final statement = new PStatement([1, 2, 3]);

      expect(statement.toSource(), equals('p 1 2 3'));
    });
  });

  group('LStatement', () {
    group('toSource', () {
      test('returns the correct value without texture vertices', () {
        final statement = new LStatement([
          new VertexNumPair(1),
          new VertexNumPair(2),
          new VertexNumPair(3),
        ]);

        expect(statement.toSource(), equals('l 1 2 3'));
      });

      test('returns the correct value with texture vertices', () {
        final statement = new LStatement([
          new VertexNumPair(1, 11),
          new VertexNumPair(2, 12),
          new VertexNumPair(3, 13),
        ]);

        expect(statement.toSource(), equals('l 1/11 2/12 3/13'));
      });
    });
  });

  group('FStatement', () {
    group('toSource', () {
      test('returns the correct value without texture vertices and without vertex normals', () {
        final statement = new FStatement([
          new VertexNumTriple(1),
          new VertexNumTriple(2),
          new VertexNumTriple(3),
        ]);

        expect(statement.toSource(), equals('f 1 2 3'));
      });

      test('returns the correct value with texture vertices and without vertex normals', () {
        final statement = new FStatement([
          new VertexNumTriple(1, 11),
          new VertexNumTriple(2, 12),
          new VertexNumTriple(3, 13),
        ]);

        expect(statement.toSource(), equals('f 1/11 2/12 3/13'));
      });

      test('returns the correct value without texture vertices and with vertex normals', () {
        final statement = new FStatement([
          new VertexNumTriple(1, null, 9),
          new VertexNumTriple(2, null, 8),
          new VertexNumTriple(3, null, 7),
        ]);

        expect(statement.toSource(), equals('f 1//9 2//8 3//7'));
      });

      test('returns the correct value with texture vertices and with vertex normals', () {
        final statement = new FStatement([
          new VertexNumTriple(1, 11, 9),
          new VertexNumTriple(2, 12, 8),
          new VertexNumTriple(3, 13, 7),
        ]);

        expect(statement.toSource(), equals('f 1/11/9 2/12/8 3/13/7'));
      });
    });
  });

  group('CurvStatement', () {
    test('toSource returns the correct value', () {
      final statement = new CurvStatement(1.0, 2.0, [10, 11, 12]);

      expect(statement.toSource(), equals('curv 1.0 2.0 10 11 12'));
    });
  });

  group('Curv2Statement', () {
    test('toSource returns the correct value', () {
      final statement = new Curv2Statement([10, 11, 12]);

      expect(statement.toSource(), equals('curv2 10 11 12'));
    });
  });

  group('SurfStatement', () {
    test('returns the correct value without texture vertices and without vertex normals', () {
      final statement = new SurfStatement(1.0, 2.0, 1.1, 2.1, [
        new VertexNumTriple(1),
        new VertexNumTriple(2),
        new VertexNumTriple(3),
      ]);

      expect(statement.toSource(), equals('surf 1.0 2.0 1.1 2.1 1 2 3'));
    });

    test('returns the correct value with texture vertices and without vertex normals', () {
      final statement = new SurfStatement(1.0, 2.0, 1.1, 2.1, [
        new VertexNumTriple(1, 11),
        new VertexNumTriple(2, 12),
        new VertexNumTriple(3, 13),
      ]);

      expect(statement.toSource(), equals('surf 1.0 2.0 1.1 2.1 1/11 2/12 3/13'));
    });

    test('returns the correct value without texture vertices and with vertex normals', () {
      final statement = new SurfStatement(1.0, 2.0, 1.1, 2.1, [
        new VertexNumTriple(1, null, 9),
        new VertexNumTriple(2, null, 8),
        new VertexNumTriple(3, null, 7),
      ]);

      expect(statement.toSource(), equals('surf 1.0 2.0 1.1 2.1 1//9 2//8 3//7'));
    });

    test('returns the correct value with texture vertices and with vertex normals', () {
      final statement = new SurfStatement(1.0, 2.0, 1.1, 2.1, [
        new VertexNumTriple(1, 11, 9),
        new VertexNumTriple(2, 12, 8),
        new VertexNumTriple(3, 13, 7),
      ]);

      expect(statement.toSource(), equals('surf 1.0 2.0 1.1 2.1 1/11/9 2/12/8 3/13/7'));
    });
  });

  group('ParmStatement', () {
    group('toSource', () {
      test('returns the correct value for parameter direction u', () {
        final statement = new ParmStatement(ParameterDirection.u, [1.0, 2.0, 3.0, 4.0]);

        expect(statement.toSource(), equals('parm u 1.0 2.0 3.0 4.0'));
      });

      test('returns the correct value for parameter direction v', () {
        final statement = new ParmStatement(ParameterDirection.v, [1.0, 2.0, 3.0, 4.0]);

        expect(statement.toSource(), equals('parm v 1.0 2.0 3.0 4.0'));
      });
    });
  });

  group('TrimStatement', () {
    test('toSource returns the correct value', () {
      final statement = new TrimStatement([
        new Curve2Instance(1.0, 2.0, 1),
        new Curve2Instance(3.0, 4.0, 2)
      ]);

      expect(statement.toSource(), equals('trim 1.0 2.0 1 3.0 4.0 2'));
    });
  });

  group('HoleStatement', () {
    test('toSource returns the correct value', () {
      final statement = new HoleStatement([
        new Curve2Instance(1.0, 2.0, 1),
        new Curve2Instance(3.0, 4.0, 2)
      ]);

      expect(statement.toSource(), equals('hole 1.0 2.0 1 3.0 4.0 2'));
    });
  });

  group('ScrvStatement', () {
    test('toSource returns the correct value', () {
      final statement = new ScrvStatement([
        new Curve2Instance(1.0, 2.0, 1),
        new Curve2Instance(3.0, 4.0, 2)
      ]);

      expect(statement.toSource(), equals('scrv 1.0 2.0 1 3.0 4.0 2'));
    });
  });

  group('SpStatement', () {
    test('toSource returns the correct value', () {
      final statement = new SpStatement([1, 2, 3]);

      expect(statement.toSource(), equals('sp 1 2 3'));
    });
  });

  group('EndStatement', () {
    test('toSource returns the correct value', () {
      final statement = new EndStatement();

      expect(statement.toSource(), equals('end'));
    });
  });

  group('ConStatement', () {
    test('toSource returns the correct value', () {
      final statement = new ConStatement(1, new Curve2Instance(1.0, 2.0, 1), 2,
        new Curve2Instance(3.0, 4.0, 2));

      expect(statement.toSource(), equals('con 1 1.0 2.0 1 2 3.0 4.0 2'));
    });
  });

  group('GStatement', () {
    test('toSource returns the correct value', () {
      final statement = new GStatement(['group1', 'group2']);

      expect(statement.toSource(), equals('g group1 group2'));
    });
  });

  group('SStatement', () {
    group('toSource', () {
      test('returns the correct value with smoothing group 0', () {
        final statement = new SStatement(0);

        expect(statement.toSource(), equals('s off'));
      });

      test('returns the correct value with smoothing group 2', () {
        final statement = new SStatement(2);

        expect(statement.toSource(), equals('s 2'));
      });
    });
  });

  group('MgStatement', () {
    group('toSource', () {
      test('returns the correct value with smoothing group 0', () {
        final statement = new MgStatement(0, 0.5);

        expect(statement.toSource(), equals('mg off'));
      });

      test('returns the correct value with smoothing group 2', () {
        final statement = new MgStatement(2, 0.5);

        expect(statement.toSource(), equals('mg 2 0.5'));
      });
    });
  });

  group('OStatement', () {
    test('toSource returns the correct value', () {
      final statement = new OStatement('object1');

      expect(statement.toSource(), equals('o object1'));
    });
  });

  group('BevelStatement', () {
    group('toSource', () {
      test('returns the correct value with bevel enabled', () {
        final statement = new BevelStatement(true);

        expect(statement.toSource(), equals('bevel on'));
      });

      test('returns the correct value with bevel disabled', () {
        final statement = new BevelStatement(false);

        expect(statement.toSource(), equals('bevel off'));
      });
    });
  });

  group('CInterpStatement', () {
    group('toSource', () {
      test('returns the correct value with color interpolation enabled', () {
        final statement = new CInterpStatement(true);

        expect(statement.toSource(), equals('c_interp on'));
      });

      test('returns the correct value with color interpolation  disabled', () {
        final statement = new CInterpStatement(false);

        expect(statement.toSource(), equals('c_interp off'));
      });
    });
  });

  group('DInterpStatement', () {
    group('toSource', () {
      test('returns the correct value with dissolve interpolation enabled', () {
        final statement = new DInterpStatement(true);

        expect(statement.toSource(), equals('d_interp on'));
      });

      test('returns the correct value with dissolve interpolation  disabled', () {
        final statement = new DInterpStatement(false);

        expect(statement.toSource(), equals('d_interp off'));
      });
    });
  });

  group('LodStatement', () {
    test('toSource returns the correct value', () {
      final statement = new LodStatement(10);

      expect(statement.toSource(), equals('lod 10'));
    });
  });

  group('MaplibStatement', () {
    test('toSource returns the correct value', () {
      final statement = new MaplibStatement(['maps1.map', 'maps2.map']);

      expect(statement.toSource(), equals('maplib maps1.map maps2.map'));
    });
  });

  group('UsemapStatement', () {
    test('toSource returns the correct value', () {
      final statement = new UsemapStatement('map1');

      expect(statement.toSource(), equals('usemap map1'));
    });
  });

  group('UsemtlStatement', () {
    test('toSource returns the correct value', () {
      final statement = new UsemtlStatement('material1');

      expect(statement.toSource(), equals('usemtl material1'));
    });
  });

  group('MtllibStatement', () {
    test('toSource returns the correct value', () {
      final statement = new MtllibStatement(['materials1.mtl', 'materials2.mtl']);

      expect(statement.toSource(), equals('mtllib materials1.mtl materials2.mtl'));
    });
  });

  group('ShadowObjStatement', () {
    test('toSource returns the correct value', () {
      final statement = new ShadowObjStatement('object1.obj');

      expect(statement.toSource(), equals('shadow_obj object1.obj'));
    });
  });

  group('TraceObjStatement', () {
    test('toSource returns the correct value', () {
      final statement = new TraceObjStatement('object1.obj');

      expect(statement.toSource(), equals('trace_obj object1.obj'));
    });
  });

  group('CtechStatement', () {
    group('toSource', () {
      test('returns the correct value with a constantParametricSubdivision technique', () {
        final statement = new CtechStatement(new CurveConstantParametricSubdivision(10.0));

        expect(statement.toSource(), equals('ctech cparm 10.0'));
      });

      test('returns the correct value with a constantSpatialSubdivision technique', () {
        final statement = new CtechStatement(new CurveConstantSpatialSubdivision(0.5));

        expect(statement.toSource(), equals('ctech cspace 0.5'));
      });

      test('returns the correct value with a curvatureDependentSubdivision technique', () {
        final statement = new CtechStatement(new CurveCurvatureDependentSubdivision(0.5, 5.0));

        expect(statement.toSource(), equals('ctech curve 0.5 5.0'));
      });
    });
  });

  group('StechStatement', () {
    group('toSource', () {
      test('returns the correct value with a constantParametricSubdivisionA technique', () {
        final statement = new StechStatement(new SurfaceConstantParametricSubdivisionA(10.0, 15.0));

        expect(statement.toSource(), equals('stech cparma 10.0 15.0'));
      });

      test('returns the correct value with a constantParametricSubdivisionB technique', () {
        final statement = new StechStatement(new SurfaceConstantParametricSubdivisionB(10.0));

        expect(statement.toSource(), equals('stech cparmb 10.0'));
      });

      test('returns the correct value with a constantSpatialSubdivision technique', () {
        final statement = new StechStatement(new SurfaceConstantSpatialSubdivision(0.5));

        expect(statement.toSource(), equals('stech cspace 0.5'));
      });

      test('returns the correct value with a curvatureDependentSubdivision technique', () {
        final statement = new StechStatement(new SurfaceCurvatureDependentSubdivision(0.5, 5.0));

        expect(statement.toSource(), equals('stech curve 0.5 5.0'));
      });
    });
  });
}
