-- Generated from ChapterNavierStokesIkebeKato.lean — theorem BookProof.NavierStokesFlow.IkebeKato.mem_maxDom
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato

variable {ι : Type*}


open scoped ENNReal



open LpNat FarisLavine

variable {ι : Type*}

const_smul a

theorem BookProof.NavierStokesFlow.IkebeKato.mem_maxDom {c : ι → ℝ} {f : L2I ι} :
    f ∈ maxDom c ↔ Memℓp (fun k => (c k : ℂ) * (f : ι := by sorry
