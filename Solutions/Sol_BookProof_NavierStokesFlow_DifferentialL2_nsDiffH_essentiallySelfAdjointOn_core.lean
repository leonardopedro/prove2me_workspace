-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.nsDiffH_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_velUnitary_mem_core
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_intertwined_canH
import Theorems.Thm_BookProof_FarisLavine_essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_canH_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_embedCore_coe
open BookProof.NavierStokesFlow.DifferentialL2




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
 i _ => hterm i

theorem solution : Real.sqrt 2 ≠ 0 :=
  ne_of_gt (Real.sqrt_pos.mpr (by norm_num))

/-- **The Navier–Stokes quadratic symbol, written with genuine derivatives and genuine
multiplication operators on `L²(du₁du₂du₃)`, is essentially self-adjoint on the Hermite
core** — for every real velocity gradient `A` and eve :=
  ry real constant part `c`. -/
  theorem nsDiffH_essentiallySelfAdjointOn_core :
      EssentiallySelfAdjointOn (polyGaussCore (d := 3))
        ((polyGaussCore (d := 3)).subtype.comp (nsDiffH A c)) := by
    rw [essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn]
    have hc : (fun j => Real.sqrt 2 * (c j / Real.sqrt 2)) = c := by
      funext j
      field_simp
    have hint : ∀ x : lpFiniteModes Vel,
        ((nsDiffH A c ⟨velUnitary ((x : L2I Vel)), velUnitary_mem_core x⟩ :
              polyGaussCore (d := 3)) : L2d 3)
          = velUnitary (((canH A (fun j => c j / Real.sqrt 2) x : lpFiniteModes Vel) : L2I Vel)) := by
      intro x
      have h := intertwined_canH A (fun j => c j / Real.sqrt 2) x
      rw [hc] at h
      have hx : (⟨velUnitary ((x : L2I Vel)), velUnitary_mem_core x⟩ : polyGaussCore (d := 3))
          = embedCore x := rfl
      rw [hx, h, embedCore_coe]
    refine hasZeroDeficiencyOn_map_of_lin
