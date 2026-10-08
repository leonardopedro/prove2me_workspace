-- Generated from ChapterSmDiracYukawa.lean — theorem BookProof.SmDiracYukawa.sm_fermi_fl_i
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar
open BookProof.SmDiracYukawa



open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section

variable {hD M : Matrix (Fin n) (Fin n) ℂ} {z : ℂ} {om : Fin n → ℝ} {c0 : ℝ}

theorem BookProof.SmDiracYukawa.sm_fermi_fl_i (hom : ∀ i, 0 ≤ om i) (hc0 : 1 ≤ c0) (x : fullDom n) :
    |quadForm (onFull (smFermiHam hD M z)) x|
      ≤ smFermiBound hD M z * quadForm (onFull (smFermiN om c0)) x := by sorry
