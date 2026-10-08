-- Generated from ChapterSmDiracYukawa.lean — theorem BookProof.SmDiracYukawa.smFermiHam_norm_le
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar
open BookProof.SmDiracYukawa



open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section


theorem BookProof.SmDiracYukawa.smFermiHam_norm_le (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) (ψ : FermiFock n) :
    ‖smFermiHam hD M z ψ‖
      ≤ (∑ i : Fin n, ∑ j : Fin n, ‖smFermiMatrix hD M z i j‖) * ‖ψ‖ := by sorry
