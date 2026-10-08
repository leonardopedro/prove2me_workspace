-- Generated from ChapterNavierStokesFockEsa.lean — theorem BookProof.NavierStokesFlow.FockOfFock.lpDiag_inner_self
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.NavierStokesFlow


open MeasureTheory



open FullEsa LagrangianEsa

variable {M : Type*} [DecidableEq M]
variable {M : Type*} [DecidableEq M] {Ω : Type*} [MeasurableSpace Ω]

theorem BookProof.NavierStokesFlow.FockOfFock.lpDiag_inner_self {ι : Type*} (c : ι → ℝ) (v : lpFiniteModes ι) :
    (inner ℂ ((v : lp (fun _ : ι => ℂ) 2))
        (((lpDiag c v : lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2)) : ℂ)
      = ((∑ i ∈ v.2.toFinset, c i * ‖((v : lp (fun _ : ι => ℂ) 2) : ι → ℂ) i‖ ^ 2 : ℝ) : ℂ) := by sorry
