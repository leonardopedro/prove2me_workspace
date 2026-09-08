import Mathlib
import Definitions.Def_timepiece_corrector
open Complex Finset Filter Topology
open scoped ArithmeticFunction ArithmeticFunction.Moebius ComplexConjugate

theorem norm_X_mult_list_eq_one (P : ℕ) (ω : Ω_infty) (L : List ℕ) :
    ‖(L.map (fun p ↦ X_p p P ω)).prod‖ = 1 := by sorry
