-- Generated from ChapterPauliLorentz.lean — theorem BookProof.ChapterPauliLorentz.det_hermMat
import Mathlib
import Definitions.Def_ChapterPauliLorentz
open BookProof.ChapterPauliLorentz


open Matrix
open scoped BigOperators

theorem BookProof.ChapterPauliLorentz.det_hermMat (x : Fin 4 → ℝ) : (hermMat x).det = (mink x : ℂ) := by sorry
