-- Generated from ChapterNavierStokesIkebeKato.lean — solution of BookProof.NavierStokesFlow.IkebeKato.mem_maxDom
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato



open scoped ENNReal



open LpNat BookProof.FarisLavine

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {c : ι → ℝ} {f : L2I ι} :
    f ∈ maxDom c ↔ Memℓp (fun k => (c k : ℂ) * (f : ι → ℂ) k) 2 := Iff.rfl
