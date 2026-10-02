-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.lagT_coreState
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_numOp_coreState
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical



open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

variable (nu : ℝ)

set_option maxHeartbeats 1000000 in
ical
  refine crd_injective ?_
  funext γ
  rw [crd_numOp, crd_smul]
  by_cases hγ : γ = β
  · subst hγ
    simp [crd_coreState]
  · simp [crd_coreState, hγ]

/-- The eigenvalue o :=
  f the second-order part at the Hermite state `e_β`:
  `ω(|β| + 3/2)`. -/
  noncomputable def lagLam (nu : ℝ) (β : Vel) : ℝ :=
    omega nu * (∑ i : Fin 3, (β i : ℝ)) + 3 * omega nu / 2
  
  /-- **The Hermite s
