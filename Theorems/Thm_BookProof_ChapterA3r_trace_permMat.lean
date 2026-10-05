-- Generated from ChapterA3r.lean — theorem BookProof.ChapterA3r.trace_permMat
import Definitions.Def_ChapterA3o
import Definitions.Def_ChapterA3q
import Mathlib
import Definitions.Def_ChapterA3r
import Definitions.Def_ChapterA3n
open BookProof.ChapterA3n
open BookProof.ChapterA3r


open Matrix
open scoped BigOperators


open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q

theorem BookProof.ChapterA3r.trace_permMat {N : ℕ} (σ : Equiv.Perm (Fin N)) :
    Matrix.trace (permMat σ) =
      ((Finset.univ.filter (fun a : Idx N => a ∘ σ = a)).card : ℂ) := by sorry
