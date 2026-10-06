-- Generated from ChapterA3e.lean — theorem BookProof.ChapterA3.lorentzLie_sum
import Mathlib
import Definitions.Def_ChapterA3e
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.lorentzLie_sum {ι : Type*} (s : Finset ι) (A : ι → Matrix (Fin 4) (Fin 4) ℝ)
    (h : ∀ i ∈ s, A i ∈ LorentzLie) : (∑ i ∈ s, A i) ∈ LorentzLie := by sorry
