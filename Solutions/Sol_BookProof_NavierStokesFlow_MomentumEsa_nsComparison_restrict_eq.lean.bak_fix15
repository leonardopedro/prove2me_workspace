-- Generated from ChapterNavierStokesMomentumEsa.lean — solution of BookProof.NavierStokesFlow.MomentumEsa.nsComparison_restrict_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_diagComparison_eq
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_coe
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumEsa





open LpNat BookProof.FarisLavine IkebeKato FarisLavineLift DiagonalEsa

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    (diagMax (nsSymbol d p q)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (nsSymbol d p q)))
      = (lpFiniteModes ℕ).subtype.comp (diagComparisonData d p q).comparison := by

  refine LinearMap.ext fun f => lp.ext (funext fun k => ?_)
  rw [diagComparison_eq]
  change ⇑((diagMax (nsSymbol d p q))
      (Submodule.inclusion (finiteModes_le_maxDom (nsSymbol d p q)) f)) k
      = ⇑((lpFiniteModes ℕ).subtype
          (diagOp (fun k' => (∑ i, p i k' ^ 2) + (∑ i, q i k' ^ 2) + 1) f)) k
  rw [diagMax_coe]
  simp [DiagonalEsa.diagFun, nsSymbol]
