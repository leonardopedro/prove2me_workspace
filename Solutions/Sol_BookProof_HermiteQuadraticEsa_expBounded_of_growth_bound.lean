-- Generated from ChapterHermiteQuadraticEsa.lean — solution of BookProof.HermiteQuadraticEsa.expBounded_of_growth_bound
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
import Theorems.Thm_BookProof_HermiteQuadraticEsa_expBounded_of_le_harm
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
theorem solution {U : Vd d → ℝ} {A Ccoef B : ℝ} (hA : 0 ≤ A)
    (hC : 0 ≤ Ccoef) (hB : 0 ≤ B)
    (hU : ∀ x, |U x - harmW x| ≤ A * ‖x‖ ^ 2 + Ccoef * ‖x‖ + B) :
    ExpBounded U := by

  refine expBounded_of_le_harm (a := 4 * A + 1 + Ccoef) (b := Ccoef + B) (by positivity)
    (by positivity) fun x => ?_
  have h := hU x
  have hharm : harmW x = ‖x‖ ^ 2 / 4 := rfl
  have hlin : Ccoef * ‖x‖ ≤ Ccoef * (‖x‖ ^ 2 / 4 + 1) :=
    mul_le_mul_of_nonneg_left (by nlinarith [sq_nonneg (‖x‖ - 2)]) hC
  have hsplit : U x = (U x - harmW x) + harmW x := by ring
  have habs : |U x| ≤ |U x - harmW x| + |harmW x| := by
    calc |U x| = |(U x - harmW x) + harmW x| := by rw [← hsplit]
      _ ≤ |U x - harmW x| + |harmW x| := abs_add_le _ _
  have hharm0 : |harmW x| = ‖x‖ ^ 2 / 4 := by
    rw [hharm, abs_of_nonneg (by positivity : (0 : ℝ) ≤ ‖x‖ ^ 2 / 4)]
  rw [hharm]
  rw [hharm0] at habs
  nlinarith [norm_nonneg x]
