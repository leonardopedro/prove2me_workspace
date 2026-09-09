-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.hFull_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_hFull_eq_add
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_secondOrder_isSymmetricDom
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_lowOrder_isSymmetricDom
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_lowOrder_relBound
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich

















open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine BookProof.KatoRellich
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace F] {kap kap' cc : ℝ}
    (hkap : 0 ≤ kap) (hkap' : 0 ≤ kap') (hcc : 0 ≤ cc)
    (hdrift : ∀ v : L.D,
      ‖(L.drift v : F)‖ ≤ kap * (∑ j : Fin 3, ‖(L.P j v : F)‖) + kap' * ‖(v : F)‖)
    (hC : ∀ v : L.D, ‖(L.constraintOp v : F)‖ ≤ cc * ‖(v : F)‖)
    (hT : EssentiallySelfAdjointOn L.D (L.D.subtype.comp (secondOrder L))) :
    EssentiallySelfAdjointOn L.D (lagrangianCore L) := by

  obtain ⟨b, hb0, hb⟩ := lowOrder_relBound L hkap hkap' hcc hdrift hC (a := 1 / 2) (by norm_num)
  have hsplit : lagrangianCore L
      = L.D.subtype.comp (secondOrder L) + L.D.subtype.comp (lowOrder L) := by
    rw [lagrangianCore, hFull_eq_add L]
    ext x
    simp
  rw [hsplit]
  refine essentiallySelfAdjointOn_add_relBounded _ _
    (fun x y => secondOrder_isSymmetricDom L x y) hT
    (fun x y => lowOrder_isSymmetricDom L x y) (a := 1 / 2) (b := b)
    (by norm_num) (by norm_num) hb0 ?_
  intro x
  simpa using hb x
