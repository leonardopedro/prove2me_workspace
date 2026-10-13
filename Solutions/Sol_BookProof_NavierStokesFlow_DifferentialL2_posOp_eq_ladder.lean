-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.posOp_eq_ladder
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_mulXPoly_apply
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterMixedLinearEsa
open BookProof.NavierStokesFlow.DifferentialL2




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

open BookProof.MixedLinearEsa
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
noncomputable section

variable {d : ℕ}


@[simp] private theorem mulXPoly_apply (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    mulXPoly i p = X i * p := rfl

set_option maxHeartbeats 1000000 in


theorem solution (i : Fin 3) : posOp i = annOp i + creOp i := by
  refine LinearMap.ext fun y => ?_
  obtain ⟨p, rfl⟩ := (coreEquiv (d := 3)).surjective y
  simp only [posOp, annOp, creOp, coreOp_coreEquiv, LinearMap.add_apply, ← map_add]
  congr 1
  -- `_root_.mulXPoly_apply` also exists (root-level, from another bundle), so the
  -- unqualified name is ambiguous / resolves to a non-proposition.
  simp only [BookProof.NavierStokesFlow.DifferentialL2.mulXPoly_apply, annPoly_apply, crePoly_apply]
  ring
