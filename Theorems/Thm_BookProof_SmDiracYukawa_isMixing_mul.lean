-- Generated from ChapterSmDiracYukawa.lean — theorem BookProof.SmDiracYukawa.isMixing_mul
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmOneParticle
open BookProof.SmOneParticle
open BookProof.SmDiracYukawa



open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section

open BookProof.SmOneParticle

theorem BookProof.SmDiracYukawa.isMixing_mul {A B : Matrix (Fin 3) (Fin 3) ℂ} (hA : IsMixing A) (hB : IsMixing B) :
    IsMixing (A * B.conjTranspose) := by sorry
