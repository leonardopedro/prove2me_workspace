-- Generated from ChapterNavierStokesIkebeKato.lean — theorem BookProof.NavierStokesFlow.IkebeKato.exists_finiteModes_graph_approx
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato

variable {ι : Type*}


open scoped ENNReal



open LpNat FarisLavine

variable {ι : Type*}

odes i (u i)

theorem BookProof.NavierStokesFlow.IkebeKato.exists_finiteModes_graph_approx (c : ι → ℝ) (x : maxDom c) (ε : ℝ) (hε : 0 < ε) :
    ∃ y : maxDom c, (y : L2I ι) ∈ lpFiniteModes ι ∧
      ‖(y : L2I ι) - (x : L2I ι)‖ < ε ∧ ‖diagMax c y - diagMa := by sorry
