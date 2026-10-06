-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.deficiencyTrivialAt_sblockH
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_sblockFun_embFun
import Theorems.Thm_BookProof_NavierStokesFlow_BilinearEsa_inner_of_block_supported
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignFlip



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}
variable {J : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (z : ℂ)
    (hblk : ∀ j, DeficiencyTrivialAt (lpFiniteModes ℕ)
      ((saffH (hκ j) (c j)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (oscSymbol (affMu (κ j) |c j|))))) z) :
    DeficiencyTrivialAt (lpFiniteModes (ℕ × J)) (sblockH κ c hκ) z := by

  intro w hw
  have hb : ∀ j, blockVec w j = 0 := by
    intro j
    refine hblk j (blockVec w j) ?_
    intro u
    have hv := hw (blockEmb j u)
    have hHcoe : ∀ q : ℕ × J,
        ((sblockH κ c hκ (blockEmb j u) : L2I (ℕ × J)) : ℕ × J → ℂ) q
          = embFun j (((((saffH (hκ j) (c j))
              (Submodule.inclusion
                (finiteModes_le_maxDom (oscSymbol (affMu (κ j) |c j|))) u) :
                L2I ℕ)) : ℕ → ℂ)) q := by
      intro q
      have hb0 : ((sblockH κ c hκ (blockEmb j u) : L2I (ℕ × J)) : ℕ × J → ℂ)
          = sblockFun κ c hκ (embFun j (((u : L2I ℕ)) : ℕ → ℂ)) := rfl
      rw [hb0, sblockFun_embFun]
      congr 1
    have h1 := inner_of_block_supported j
      ((sblockH κ c hκ (blockEmb j u) : L2I (ℕ × J)))
      (((saffH (hκ j) (c j))
        (Submodule.inclusion
          (finiteModes_le_maxDom (oscSymbol (affMu (κ j) |c j|))) u) : L2I ℕ)) hHcoe w
    have h2 := inner_of_block_supported j
      (((blockEmb j u : lpFiniteModes (ℕ × J)) : L2I (ℕ × J))) ((u : L2I ℕ))
      (fun _ => rfl) w
    rw [h1, h2] at hv
    exact hv
  refine lp.ext (funext fun q => ?_)
  obtain ⟨n, j⟩ := q
  have hz := congrArg (fun v : L2I ℕ => ((v : ℕ → ℂ)) n) (hb j)
  simpa using hz
