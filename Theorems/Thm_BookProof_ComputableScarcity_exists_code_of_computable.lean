-- Generated from ChapterComputableScarcity.lean — theorem BookProof.ComputableScarcity.exists_code_of_computable
import Mathlib
import Definitions.Def_ChapterComputableScarcity
open BookProof.ComputableScarcity



open Nat.Partrec

open Classical

theorem BookProof.ComputableScarcity.exists_code_of_computable {f : ℕ → ℕ} (hf : Computable f) :
    ∃ c : Code, evalTotal c = f := by sorry
