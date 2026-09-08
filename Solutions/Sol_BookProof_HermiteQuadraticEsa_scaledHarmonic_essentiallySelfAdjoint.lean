-- Generated from ChapterHermiteQuadraticEsa.lean — solution of BookProof.HermiteQuadraticEsa.scaledHarmonic_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
import Theorems.Thm_BookProof_HermiteQuadraticEsa_esa_of_close_to_harmonic
open BookProof.HermiteQuadraticEsa















open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {lam : ℝ} (h0 : 0 < lam) (h2 : lam < 2)
    (hsc : Continuous fun x : Vd d => lam * harmW x)
    (hsb : ExpBounded fun x : Vd d => lam * harmW x) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d))
      (hamCore (fun x : Vd d => lam * harmW x) hsc hsb) := by

  refine esa_of_close_to_harmonic hsc hsb (a := |lam - 1|) (b := 0) (abs_nonneg _)
    (by rw [abs_lt]; constructor <;> linarith) le_rfl fun x => ?_
  have hharm : (0 : ℝ) ≤ harmW x := by unfold harmW; positivity
  have : lam * harmW x - harmW x = (lam - 1) * harmW x := by ring
  rw [this, abs_mul, abs_of_nonneg hharm]
  linarith
