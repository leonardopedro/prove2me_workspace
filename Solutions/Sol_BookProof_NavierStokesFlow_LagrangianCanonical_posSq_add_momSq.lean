-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.posSq_add_momSq
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_ann_comp_cre_eq
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical

















open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato  BookProof.NavierStokesFlow.LagrangianKatoRellich
open BookProof.NavierStokesFlow.CanonicalVector BookProof.NavierStokesFlow.ThreeComponent

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) :
    (pos i).comp (pos i) + (mom i).comp (mom i)
      = (2 : ℂ) • numOp i + LinearMap.id := by

  have hhalf : ((1 / Real.sqrt 2 : ℝ) : ℂ) * ((1 / Real.sqrt 2 : ℝ) : ℂ) = (1 / 2 : ℂ) := by
    rw [inv_sqrt_two_sq]; norm_num
  have h1 : (pos i).comp (pos i)
      = (1 / 2 : ℂ) • ((cre i + ann i).comp (cre i + ann i)) := by
    simp only [pos, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul, hhalf]
  have h2 : (mom i).comp (mom i)
      = (-(1 / 2 : ℂ)) • ((cre i - ann i).comp (cre i - ann i)) := by
    simp only [mom, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul]
    congr 1
    have : Complex.I * ((1 / Real.sqrt 2 : ℝ) : ℂ) * (Complex.I * ((1 / Real.sqrt 2 : ℝ) : ℂ))
        = (Complex.I * Complex.I)
          * (((1 / Real.sqrt 2 : ℝ) : ℂ) * ((1 / Real.sqrt 2 : ℝ) : ℂ)) := by ring
    rw [this, hhalf, Complex.I_mul_I]
    ring
  have hPM : (cre i + ann i).comp (cre i + ann i) - (cre i - ann i).comp (cre i - ann i)
      = (2 : ℂ) • ((cre i).comp (ann i)) + (2 : ℂ) • ((ann i).comp (cre i)) := by
    simp only [LinearMap.comp_add, LinearMap.add_comp, LinearMap.comp_sub, LinearMap.sub_comp]
    module
  have hsplit : (pos i).comp (pos i) + (mom i).comp (mom i)
      = (1 / 2 : ℂ) • ((cre i + ann i).comp (cre i + ann i)
          - (cre i - ann i).comp (cre i - ann i)) := by
    rw [h1, h2]; module
  rw [hsplit, hPM, ann_comp_cre_eq i]
  simp only [numOp]
  module
