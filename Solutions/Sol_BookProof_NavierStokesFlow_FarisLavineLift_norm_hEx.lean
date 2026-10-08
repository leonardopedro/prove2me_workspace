-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.norm_hEx
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift





open FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ} (c : ComparisonData F d)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {κ : Type*}

set_option maxHeartbeats 1000000 in
noncomputable def vEx : E2 :=
  ace.single k (1 : ℂ))
  
  theorem norm_hEx (k : Fin 2) (x : E2) : ‖hEx k x‖ = ‖x k‖ :=
