-- Generated from ChapterSmDiracYukawa.lean — theorem BookProof.SmDiracYukawa.fermiBilin_add
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.SmCar
open BookProof.SmDiracYukawa

variable {n : ℕ}



open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine


noncomputable section

theorem BookProof.SmDiracYukawa.fermiBilin_add (A B : Matrix (Fin n) (Fin n) ℂ) :
    fermiBilin (A + B) = fermiBilin A + fermiBilin B := by sorry
