-- Generated from ChapterNavierStokesFockSpace.lean — theorem BookProof.NavierStokesFlow.FockOfFock.lpFiniteModes_sum_repr
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock

variable {ι : Type*}
variable {M : Type*} [DecidableEq M]




open FullEsa

theorem BookProof.NavierStokesFlow.FockOfFock.lpFiniteModes_sum_repr {ι : Type*} [DecidableEq ι] (f : lpFiniteModes ι) :
    f = ∑ i ∈ f.2.toFinset, (((f : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i) • lpBasis i := by sorry
