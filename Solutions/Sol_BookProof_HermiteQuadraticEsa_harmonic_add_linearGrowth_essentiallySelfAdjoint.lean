-- Generated from ChapterHermiteQuadraticEsa.lean — solution of BookProof.HermiteQuadraticEsa.harmonic_add_linearGrowth_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
import Theorems.Thm_BookProof_HermiteQuadraticEsa_quadraticGrowth_essentiallySelfAdjoint
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
theorem solution {V : Vd d → ℝ} {Ccoef B : ℝ}
    (hB : 0 ≤ B)
    (hV : ∀ x, |V x| ≤ Ccoef * ‖x‖ + B)
    (hsc : Continuous fun x => harmW x + V x) (hsb : ExpBounded fun x => harmW x + V x) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d))
      (hamCore (fun x => harmW x + V x) hsc hsb) := by

  refine quadraticGrowth_essentiallySelfAdjoint (A := 0) (Ccoef := Ccoef) (B := B) hsc hsb
    le_rfl (by norm_num) hB fun x => ?_
  have h := hV x
  have : harmW x + V x - harmW x = V x := by ring
  rw [this]
  linarith
