-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.lpFiniteModes_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}


open scoped Matrix




.mem_support] at hj
  by_contra hne
  have hjk : j ≠ k := by simpa using hne
  exact hj (by simp [lp.single_apply, Pi.single_eq_of_ne hjk])

/-- **The finite-mode domain is dense**: every `ℓ²` state is the limit of its
finite truncations. -/ := by sorry
