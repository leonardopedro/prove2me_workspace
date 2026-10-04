-- Generated from ChapterA4g.lean — theorem BookProof.ChapterA4g.transPhase_add
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterA4g
import Definitions.Def_ChapterLorentzTranslation
import Definitions.Def_ChapterA4
open BookProof.ChapterLorentzTranslation
open BookProof.ChapterA4g


open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3

theorem BookProof.ChapterA4g.transPhase_add (p a b : Fin 3 → ℝ) :
    transPhase p (a + b) = transPhase p a * transPhase p b := by sorry
