-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.toLp_hermiteR_smul
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_hermiteNorm_pos
import Theorems.Thm_BookProof_HermiteCore_memLp_poly_mul_gaussH
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in

    (memLp_poly_mul_gaussH (p + q)).toLp _
      = (memLp_poly_mul_gaussH p).toLp _ + (memLp_poly_mul_gaussH q).toLp _ := by
  rw [Lp.ext_iff]
  filter_upwards [(memLp_poly_mul_gaussH (p + q)).coeFn_toLp,
    Lp.coeFn_add ((memLp_poly_mul_gaussH p).toLp _) ( :=
  (memLp_poly_mul_gaussH q).toLp _),
      (memLp_poly_mul_gaussH p).coeFn_toLp, (memLp_poly_mul_gaussH q).coeFn_toLp]
      with x h0 h1 h2 h3
    rw [h0, h1, Pi.add_apply, h2, h3]
    simp only [Polynomial.eval_add]
    push_cast
    ring
  
  /-- A multiple of a Hermite polynomial times the Gaussian is a multiple of a
  Hermite function. -/
  theorem toLp_hermiteR_smul (n : ℕ) (c : ℝ) :
      (memLp_poly_mul_gaussH (C c * hermiteR n)).toLp _
        = ((c * hermiteNorm n : ℝ) : ℂ)
