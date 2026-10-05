-- Generated from ChapterFreeFieldBornSignOrientationKernel.lean — theorem BookProof.ChapterFreeFieldBornSignOrientationKernel.even_flipCount_xor_iff
import Definitions.Def_ChapterFreeFieldBornSignHom
import Definitions.Def_ChapterFreeFieldBornSignMatrix
import Definitions.Def_ChapterFreeFieldBornSignOrientation
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignOrientationKernel
open BookProof.ChapterFreeFieldBornSignOrientationKernel

variable {n : ℕ}


open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignOrientation



theorem BookProof.ChapterFreeFieldBornSignOrientationKernel.even_flipCount_xor_iff (b₁ b₂ : Fin n → Bool) :
    Even (flipCount (fun k => xor (b₁ k) (b₂ k))) ↔
      (Even (flipCount b₁) ↔ Even (flipCount b₂)) := by sorry
