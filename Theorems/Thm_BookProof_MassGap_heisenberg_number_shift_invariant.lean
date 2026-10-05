-- Generated from ChapterMassGap.lean — theorem BookProof.MassGap.heisenberg_number_shift_invariant
import Mathlib
import Definitions.Def_ChapterMassGap
open BookProof.MassGap

variable {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℂ 𝔸] [CompleteSpace 𝔸]



open scoped BigOperators

theorem BookProof.MassGap.heisenberg_number_shift_invariant (H N Obs : 𝔸) (t lam : ℂ)
    (hHN : Commute H N) (hON : Commute Obs N) :
    NormedSpace.exp (t • (H + lam • N)) * Obs * NormedSpace.exp (-(t • (H + lam • N)))
      = NormedSpace.exp (t • H) * Obs * NormedSpace.exp (-(t • H)) := by sorry
