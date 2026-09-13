-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.diagOp_one
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Definitions.Def_ChapterNavierStokesFullEsa
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift











open BookProof.NavierStokesFlow.FullEsa



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



variable {d : ℕ} (c : ComparisonData F d)











open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.DiagonalEsa

set_option maxHeartbeats 1000000 in
theorem solution :
    (LinearMap.id : lpFiniteModes ℕ →ₗ[ℂ] lpFiniteModes ℕ) = diagOp (fun _ => 1) := by

  refine LinearMap.ext fun f => Subtype.ext (lp.ext ?_)
  funext n
  simp [diagOp, diagFun]
