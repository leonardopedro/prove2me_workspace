-- Generated from ChapterHermiteQuadraticEsa.lean — solution of BookProof.HermiteQuadraticEsa.esa_of_close_to_harmonic
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
import Theorems.Thm_BookProof_HermiteQuadraticEsa_harmonic_add_subquadratic_essentiallySelfAdjoint
import Theorems.Thm_BookProof_HermiteQuadraticEsa_hamCore_congr
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
theorem solution {U : Vd d → ℝ} (hUc : Continuous U) (hUb : ExpBounded U)
    {a b : ℝ} (ha : 0 ≤ a) (ha1 : a < 1) (hb : 0 ≤ b)
    (hU : ∀ x, |U x - harmW x| ≤ a * harmW x + b) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (hamCore U hUc hUb) := by

  have hfun : (fun x => harmW x + (U x - harmW x)) = U := by
    funext x; ring
  have hsc : Continuous fun x => harmW x + (U x - harmW x) := by
    rw [hfun]; exact hUc
  have hsb : ExpBounded fun x => harmW x + (U x - harmW x) := by
    rw [hfun]; exact hUb
  have h := harmonic_add_subquadratic_essentiallySelfAdjoint (V := fun x => U x - harmW x)
    (hUc.sub continuous_harmW) ha ha1 hb hU hsc hsb
  rwa [hamCore_congr hfun hsc hsb hUc hUb] at h
