-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.lpFiniteModes_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.NavierStokesFlow








open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

















variable {ι : Type*}

theorem BookProof.NavierStokesFlow.lpFiniteModes_dense :
    Dense ((lpFiniteModes ι : Submodule ℂ (lp (fun _ : ι => ℂ) 2)) :
      Set (lp (fun _ : ι => ℂ) 2)) := by sorry
