-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.lagCan_secondOrder_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_half_lagPSq_add_nu_lagQSq
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

variable (nu : ℝ)

set_option maxHeartbeats 1000000 in
open BookProof.BRSTNilpotent BookProof.ChapterF7 BookProof.NavierStokesFlow.LagrangianEsa.LagrangianFullData
theorem solution (hnu : 0 < nu) (f : Fin 3 → ℝ) :
    secondOrder (lagCanData nu hnu f) = lagT nu := by

  simp only [lagCanData, lagT]
  have hmode := fun i => half_lagPSq_add_nu_lagQSq nu hnu i
  have hhalf : ((1 / 2 : ℝ) : ℂ) = (1 / 2 : ℂ) := by push_cast; ring
  have hcnt :
      (∑ i : Fin 3, ((omega nu / 2 : ℝ) : ℂ) • LinearMap.id :
        lpFiniteModes Vel →ₗ[ℂ] lpFiniteModes Vel)
      = ((3 * omega nu / 2 : ℝ) : ℂ) • LinearMap.id := by
    rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, ← Nat.cast_smul_eq_nsmul ℂ,
      smul_smul]
    congr 1
    push_cast
    ring
  have hbridge : (∑ i : Fin
