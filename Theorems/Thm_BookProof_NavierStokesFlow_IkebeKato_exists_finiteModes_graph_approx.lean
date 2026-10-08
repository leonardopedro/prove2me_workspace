-- Generated from ChapterNavierStokesIkebeKato.lean — theorem BookProof.NavierStokesFlow.IkebeKato.exists_finiteModes_graph_approx
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato


open scoped ENNReal



open LpNat BookProof.FarisLavine

variable {ι : Type*}


theorem BookProof.NavierStokesFlow.IkebeKato.exists_finiteModes_graph_approx (c : ι → ℝ) (x : maxDom c) (ε : ℝ) (hε : 0 < ε) :
    ∃ y : maxDom c, (y : L2I ι) ∈ lpFiniteModes ι ∧
      ‖(y : L2I ι) - (x : L2I ι)‖ < ε ∧ ‖diagMax c y - diagMax c x‖ < ε := by sorry
