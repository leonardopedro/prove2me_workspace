-- Generated from ChapterNavierStokesBilinearEsa.lean — solution of BookProof.NavierStokesFlow.BilinearEsa.deficiencyTrivialAt_bilH
import Mathlib
import Definitions.Def_ChapterNavierStokesBilinearEsa
import Theorems.Thm_BookProof_NavierStokesFlow_BilinearEsa_inner_of_block_supported
import Theorems.Thm_BookProof_NavierStokesFlow_BilinearEsa_bilFun_embFun
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine

variable {J : Type*}

variable {J : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (κ : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (z : ℂ)
    (hblk : ∀ j, DeficiencyTrivialAt (lpFiniteModes ℕ)
      ((nsH (κ j) (hκ j)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (oscSymbol (κ j))))) z) :
    DeficiencyTrivialAt (lpFiniteModes (ℕ × J)) (bilH κ) z := by

  intro w hw
  have hb : ∀ j, blockVec w j = 0 := by
    intro j
    refine hblk j (blockVec w j) ?_
    intro u
    have hv := hw (blockEmb j u)
    have hHcoe : ∀ p : ℕ × J,
        ((bilH κ (blockEmb j u) : L2I (ℕ × J)) : ℕ × J → ℂ) p
          = embFun j (((((nsH (κ j) (hκ j))
              (Submodule.inclusion (finiteModes_le_maxDom (oscSymbol (κ j))) u) :
                L2I ℕ)) : ℕ → ℂ)) p := by
      intro p
      have hb0 : ((bilH κ (blockEmb j u) : L2I (ℕ × J)) : ℕ × J → ℂ)
          = bilFun κ (embFun j (((u : L2I ℕ)) : ℕ → ℂ)) := rfl
      rw [hb0, bilFun_embFun]
      rfl
    have h1 := inner_of_block_supported j ((bilH κ (blockEmb j u) : L2I (ℕ × J)))
      (((nsH (κ j) (hκ j))
        (Submodule.inclusion (finiteModes_le_maxDom (oscSymbol (κ j))) u) : L2I ℕ)) hHcoe w
    have h2 := inner_of_block_supported j
      (((blockEmb j u : lpFiniteModes (ℕ × J)) : L2I (ℕ × J))) ((u : L2I ℕ))
      (fun _ => rfl) w
    rw [h1, h2] at hv
    exact hv
  refine lp.ext (funext fun p => ?_)
  obtain ⟨n, j⟩ := p
  have hz := congrArg (fun v : L2I ℕ => ((v : ℕ → ℂ)) n) (hb j)
  simpa using hz
