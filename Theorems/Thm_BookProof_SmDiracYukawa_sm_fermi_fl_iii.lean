-- Generated from ChapterSmDiracYukawa.lean — theorem BookProof.SmDiracYukawa.sm_fermi_fl_iii
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

variable {hD M : Matrix (Fin n) (Fin n) ℂ} {z : ℂ} {om : Fin n → ℝ} {c0 : ℝ}

theorem BookProof.SmDiracYukawa.sm_fermi_fl_iii (hom : ∀ i, 0 ≤ om i) (hc0 : 1 ≤ c0) (x : fullDom n) :
    |(inner ℂ (x : FermiFock n)
        (dcommOp (smFermiHam hD M z) (smFermiN om c0) (x : FermiFock n)) : ℂ).re|
      ≤ (4 * smFermiBound hD M z * smFermiOm om c0 ^ 2)
        * ‖smFermiN om c0 (x : FermiFock n)‖ ^ 2 := by sorry
