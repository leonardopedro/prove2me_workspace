-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.toLp_hermiteR_smul
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

theorem BookProof.HermiteCore.toLp_hermiteR_smul (n : ℕ) (c : ℝ) :
    (memLp_poly_mul_gaussH (C c * hermiteR n)).toLp _
      = ((c * hermiteNorm n : ℝ) : ℂ) • hermiteLp n := by sorry
