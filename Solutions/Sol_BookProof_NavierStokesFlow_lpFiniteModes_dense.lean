-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.lpFiniteModes_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Theorems.Thm_BookProof_NavierStokesFlow_lpSingle_mem_lpFiniteModes
open BookProof.NavierStokesFlow



open scoped Matrix lp



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
.mem_support] at hj
  by_contra hne
  have hjk : j ≠ k := by simpa using hne
  exact hj (by simp [lp.single_apply, Pi.single_eq_of_ne hjk])

/-- **The finite-mode domain is dense**: every `ℓ²` state is the limit of its
finite truncations. -/ :=
  theorem lpFiniteModes_dense :
      Dense ((lpFiniteModes ι : Submodule ℂ (lp (fun _ : ι => ℂ) 2)) :
        Set (lp (fun _ : ι => ℂ) 2)) := by
    classical
    intro f
    refine mem_clo
