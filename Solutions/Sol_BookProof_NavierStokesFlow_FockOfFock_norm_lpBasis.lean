-- Generated from ChapterNavierStokesFockSpace.lean — solution of BookProof.NavierStokesFlow.FockOfFock.norm_lpBasis
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock









open FullEsa



variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution [DecidableEq ι] (i : ι) : ‖lpBasis (ι := ι) i‖ = 1 := by

  have : ‖((lpBasis i : lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2)‖ = ‖(1 : ℂ)‖ :=
    lp.norm_single (by norm_num) i 1
  simpa using this
