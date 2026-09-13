-- Generated from ChapterHermiteQuadraticEsa.lean — solution of BookProof.HermiteQuadraticEsa.sectorQuad_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
import Theorems.Thm_BookProof_HermiteQuadraticEsa_quadraticGrowth_essentiallySelfAdjoint
import Theorems.Thm_BookProof_HermiteQuadraticEsa_continuous_sectorQuadW
import Theorems.Thm_BookProof_HermiteQuadraticEsa_abs_sectorQuadW_sub_harmW_le
import Theorems.Thm_BookProof_HermiteQuadraticEsa_expBounded_sectorQuadW
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
theorem solution (M alpha mu : ℝ) (ha0 : 0 < alpha)
    (ha2 : alpha < 1 / 2) (hm0 : 0 < mu) (hm2 : mu < 1 / 2) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 2))
      (hamCore (sectorQuadW M alpha mu) (continuous_sectorQuadW M alpha mu)
        (expBounded_sectorQuadW M alpha mu)) := by

  refine quadraticGrowth_essentiallySelfAdjoint (A := max |alpha - 1 / 4| |mu - 1 / 4|)
    (Ccoef := M ^ 2 / 2) (B := 0) _ _ (le_trans (abs_nonneg _) (le_max_left _ _)) ?_ le_rfl
    (abs_sectorQuadW_sub_harmW_le M alpha mu)
  have h1 : |alpha - 1 / 4| < 1 / 4 := by
    rw [abs_lt]; constructor <;> linarith
  have h2 : |mu - 1 / 4| < 1 / 4 := by
    rw [abs_lt]; constructor <;> linarith
  have hmax : max |alpha - 1 / 4| |mu - 1 / 4| < 1 / 4 := max_lt h1 h2
  linarith
