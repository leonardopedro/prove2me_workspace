-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.toLp_hermiteR_smul
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section


    (memLp_poly_mul_gaussH (p + q)).toLp _
      = (memLp_poly_mul_gaussH p).toLp _ + (memLp_poly_mul_gaussH q).toLp _ := by
  rw [Lp.ext_iff]
  filter_upwards [(memLp_poly_mul_gaussH (p + q)).coeFn_toLp,
    Lp.coeFn_add ((memLp_poly_mul_gaussH p).toLp _) ( := by sorry
