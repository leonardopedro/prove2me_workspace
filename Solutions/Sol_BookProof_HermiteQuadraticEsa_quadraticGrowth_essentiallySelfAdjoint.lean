-- Generated from ChapterHermiteQuadraticEsa.lean — solution of BookProof.HermiteQuadraticEsa.quadraticGrowth_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
import Theorems.Thm_BookProof_HermiteQuadraticEsa_esa_of_close_to_harmonic
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterFiniteSectionSingleTime
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterBandEnclosure
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
open BookProof.HermiteQuadraticEsa















open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {U : Vd d → ℝ} (hUc : Continuous U)
    (hUb : ExpBounded U) {A Ccoef B : ℝ} (hA : 0 ≤ A) (hA1 : 4 * A < 1)
    (hB : 0 ≤ B) (hU : ∀ x, |U x - harmW x| ≤ A * ‖x‖ ^ 2 + Ccoef * ‖x‖ + B) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (hamCore U hUc hUb) := by

  set e : ℝ := (1 - 4 * A) / 2 with he
  have he0 : 0 < e := by rw [he]; linarith
  have hene : e ≠ 0 := ne_of_gt he0
  refine esa_of_close_to_harmonic hUc hUb (a := 4 * A + e) (b := B + Ccoef ^ 2 / e)
    (by positivity) (by rw [he]; linarith) (by positivity) fun x => ?_
  have hharm : harmW x = ‖x‖ ^ 2 / 4 := rfl
  have hk : Ccoef ^ 2 / e * e = Ccoef ^ 2 := div_mul_cancel₀ _ hene
  have hlin : Ccoef * ‖x‖ ≤ e / 4 * ‖x‖ ^ 2 + Ccoef ^ 2 / e := by
    nlinarith [sq_nonneg (e * ‖x‖ - 2 * Ccoef), he0, norm_nonneg x]
  have h := hU x
  rw [hharm] at h ⊢
  linarith
