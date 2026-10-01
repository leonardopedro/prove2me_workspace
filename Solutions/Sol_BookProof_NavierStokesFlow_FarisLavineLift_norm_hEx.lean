-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.norm_hEx
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift





open FullEsa

set_option maxHeartbeats 1000000 in
: Fin 2) : E2 →ₗ[ℂ] E2 :=
  LinearMap.smulRight (EuclideanSpace.projₗ (𝕜 := ℂ) k) (EuclideanSp :=
  ace.single k (1 : ℂ))
  
  theorem norm_hEx (k : Fin 2) (x : E2) : ‖hEx k x‖ = ‖x k‖ :=
