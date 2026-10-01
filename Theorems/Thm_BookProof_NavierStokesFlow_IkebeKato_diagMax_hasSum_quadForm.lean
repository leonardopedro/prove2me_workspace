-- Generated from ChapterNavierStokesIkebeKato.lean — theorem BookProof.NavierStokesFlow.IkebeKato.diagMax_hasSum_quadForm
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato

variable {ι : Type*}


open scoped ENNReal



open LpNat FarisLavine

variable {ι : Type*}

Real]
  ring

theorem BookProof.NavierStokesFlow.IkebeKato.diagMax_hasSum_quadForm (c : ι → ℝ) (x : maxDom c) :
    HasSum (fun k => c k * ‖((x : L2I ι) : ι → ℂ) k‖ ^ 2) (quadForm ( := by sorry
