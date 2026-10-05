-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.eGram_eq_torsion_add_gauge3d
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
open BookProof.QgFullEliminated




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgFourierElim

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : Mom) (c d : EComp) :
    eGram (k, c) (k, d)
      = (∑ mu : Fin 3, ∑ nu : Fin 3, ∑ i : Fin 3,
            (starRingEnd ℂ) (elimCoef k (torsionF mu nu i) c) * elimCoef k (torsionF mu nu i) d)
        + ∑ i : Fin 3,
            (starRingEnd ℂ) (elimCoef k (gauge3dF i) c) * elimCoef k (gauge3dF i) d := by

  have hd : ∀ p : Fin 3 × Fin 3 × Fin 3,
      (starRingEnd ℂ) (elimCoef k (Sum.inr (Sum.inl p)) c) * elimCoef k (Sum.inr (Sum.inl p)) d
        = 0 := by
    intro p
    obtain ⟨mu, nu, i⟩ := p
    have hF : (Sum.inr (Sum.inl (mu, nu, i)) : FormIdx) = dGaugeF mu nu i := rfl
    simp only [hF, elimCoef_dGauge, map_zero, zero_mul]
  have htor : (∑ p : Fin 3 × Fin 3 × Fin 3,
        (starRingEnd ℂ) (elimCoef k (Sum.inl p) c) * elimCoef k (Sum.inl p) d)
      = ∑ mu : Fin 3, ∑ nu : Fin 3, ∑ i : Fin 3,
          (starRingEnd ℂ) (elimCoef k (torsionF mu nu i) c)
            * elimCoef k (torsionF mu nu i) d := by
    rw [Fintype.sum_prod_type]
    refine Finset.sum_congr rfl fun mu _ => ?_
    rw [Fintype.sum_prod_type]
    rfl
  have hgauge : (∑ p : (Fin 3 × Fin 3 × Fin 3) ⊕ Fin 3,
        (starRingEnd ℂ) (elimCoef k (Sum.inr p) c) * elimCoef k (Sum.inr p) d)
      = ∑ i : Fin 3, (starRingEnd ℂ) (elimCoef k (gauge3dF i) c) * elimCoef k (gauge3dF i) d := by
    rw [Fintype.sum_sum_type, Finset.sum_congr rfl fun p _ => hd p, Finset.sum_const_zero,
      zero_add]
    rfl
  have hsplit : eGram (k, c) (k, d)
      = (∑ p : Fin 3 × Fin 3 × Fin 3,
            (starRingEnd ℂ) (elimCoef k (Sum.inl p) c) * elimCoef k (Sum.inl p) d)
        + ∑ p : (Fin 3 × Fin 3 × Fin 3) ⊕ Fin 3,
            (starRingEnd ℂ) (elimCoef k (Sum.inr p) c) * elimCoef k (Sum.inr p) d := by
    have hval : eGram ((k, c) : EGMode) (k, d)
        = ∑ F : FormIdx, (starRingEnd ℂ) (elimCoef k F c) * elimCoef k F d := by
      simp [eGram]
    rw [hval, Fintype.sum_sum_type]
  rw [hsplit, htor, hgauge]
