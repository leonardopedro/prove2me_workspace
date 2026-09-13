-- Generated from ChapterHermiteQuadraticEsa.lean — solution of BookProof.HermiteQuadraticEsa.harmonic_add_subquadratic_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
import Theorems.Thm_BookProof_HermiteQuadraticEsa_norm_harmPoly_mul_le
import Theorems.Thm_BookProof_HermiteQuadraticEsa_expBounded_of_le_harm
import Theorems.Thm_BookProof_HermiteQuadraticEsa_norm_potLp_le_of_le_harm
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
theorem solution {V : Vd d → ℝ} {a b : ℝ}
    (hVc : Continuous V) (ha : 0 ≤ a) (ha1 : a < 1) (hb : 0 ≤ b)
    (hV : ∀ x, |V x| ≤ a * harmW x + b)
    (hsc : Continuous fun x => harmW x + V x) (hsb : ExpBounded fun x => harmW x + V x) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d))
      (hamCore (fun x => harmW x + V x) hsc hsb) := by

  have hVb : ExpBounded V := expBounded_of_le_harm ha hb hV
  have hs0 : (0 : ℝ) ≤ Real.sqrt ((d : ℝ) / 2) := Real.sqrt_nonneg _
  rw [hamCore_add_potential harmW V continuous_harmW expBounded_harmW hVc hVb hsc hsb]
  refine BookProof.KatoRellich.essentiallySelfAdjointOn_add_relBounded
    (a := a) (b := a * Real.sqrt ((d : ℝ) / 2) + b) _ _
    harmonicCore_symmetricOn harmonicCore_essentiallySelfAdjoint
    (potCore_symmetricOn V hVc hVb) ha ha1 (by positivity) fun x => ?_
  obtain ⟨p, hp⟩ := x.2
  have hx : x = ⟨pgLp p, pgLp_mem_core p⟩ := Subtype.ext hp.symm
  rw [hx, potCore_pgLp]
  have hham : (hamCore harmW continuous_harmW expBounded_harmW) ⟨pgLp p, pgLp_mem_core p⟩
      = pgLp (kinPoly p + harmPoly * p) := harmCore_pgLp p
  rw [hham]
  have h1 := norm_potLp_le_of_le_harm hVc hVb ha hb hV p
  have h2 := norm_harmPoly_mul_le p
  have hcoe : ‖((⟨pgLp p, pgLp_mem_core p⟩ : polyGaussCore (d := d)) : L2d d)‖ = ‖pgLp p‖ := rfl
  rw [hcoe]
  nlinarith [norm_nonneg (pgLp p), norm_nonneg (pgLp (kinPoly p + harmPoly * p))]
