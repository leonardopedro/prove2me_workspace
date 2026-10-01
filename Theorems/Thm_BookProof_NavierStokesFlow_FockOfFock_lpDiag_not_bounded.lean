-- Generated from ChapterNavierStokesFockSpace.lean — theorem BookProof.NavierStokesFlow.FockOfFock.lpDiag_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock

variable {ι : Type*}
variable {ι : Type*}
variable {M : Type*} [DecidableEq M]
variable {J K : Type*} [DecidableEq J] [DecidableEq K]




open FullEsa

theorem BookProof.NavierStokesFlow.FockOfFock.lpDiag_not_bounded (c : ι → ℝ) (hc : ∀ C : ℝ, ∃ i, C < |c i|) :
    ¬ ∃ C : ℝ, ∀ f : lpFiniteModes ι, ‖lpDiag c f‖ ≤ C * ‖f‖ := by sorry
