-- Generated from ChapterSmDiracYukawa.lean — theorem BookProof.SmDiracYukawa.smFermiOm_nonneg
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
open BookProof.SmDiracYukawa

variable {n : ℕ}
variable {hD M : Matrix (Fin n) (Fin n) ℂ} {z : ℂ} {om : Fin n → ℝ} {c0 : ℝ}



open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine


noncomputable section

theorem BookProof.SmDiracYukawa.smFermiOm_nonneg (hom : ∀ i, 0 ≤ om i) (hc0 : 1 ≤ c0) : 0 ≤ smFermiOm om c0 := by sorry
