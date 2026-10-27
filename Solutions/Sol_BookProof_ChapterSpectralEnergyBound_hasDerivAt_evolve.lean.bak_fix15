-- Generated from ChapterSpectralEnergyBound.lean — solution of BookProof.ChapterSpectralEnergyBound.hasDerivAt_evolve
import Mathlib
import Definitions.Def_ChapterSpectralEnergyBound
open BookProof.ChapterSpectralEnergyBound




variable {n : Type*} [Fintype n]

variable {n : Type*} [Fintype n]

set_option maxHeartbeats 1000000 in
theorem solution (f : n → ℝ) (v : EuclideanSpace ℂ n) (t : ℝ) :
    HasDerivAt (fun s : ℝ => evolve f s v)
      (-Complex.I • diagOp f (evolve f t v)) t := by

  classical
  have hg : HasDerivAt
      (fun s : ℝ => (fun i => Complex.exp (-Complex.I * (s : ℂ) * (f i : ℂ)) * v i : n → ℂ))
      (fun i => (-Complex.I * (f i : ℂ)) *
        (Complex.exp (-Complex.I * (t : ℂ) * (f i : ℂ)) * v i)) t := by
    apply hasDerivAt_pi.2
    intro i
    have h1 : HasDerivAt (fun s : ℝ => (s : ℂ)) 1 t := Complex.ofRealCLM.hasDerivAt
    have hbase : HasDerivAt (fun s : ℝ => -Complex.I * (s : ℂ) * (f i : ℂ))
        (-Complex.I * (f i : ℂ)) t := by
      simpa [mul_comm, mul_left_comm, mul_assoc] using
        ((h1.const_mul (-Complex.I)).mul_const (f i : ℂ))
    have hexp := (hbase.cexp).mul_const (v i)
    convert hexp using 1 <;> first | rfl | ring
  have hfun : (fun s : ℝ => evolve f s v)
      = fun s : ℝ => (EuclideanSpace.equiv n ℂ).symm
          (fun i => Complex.exp (-Complex.I * (s : ℂ) * (f i : ℂ)) * v i) := by
    funext s
    rfl
  rw [hfun]
  have h1 : (EuclideanSpace.equiv n ℂ) (-Complex.I • diagOp f (evolve f t v))
      = fun i => (-Complex.I * (f i : ℂ)) *
          (Complex.exp (-Complex.I * (t : ℂ) * (f i : ℂ)) * v i) := by
    funext i
    simp [diagOp, evolve, smul_eq_mul, mul_assoc, mul_left_comm, mul_comm] <;> ring
  have hd : -Complex.I • diagOp f (evolve f t v)
      = (EuclideanSpace.equiv n ℂ).symm
          (fun i => (-Complex.I * (f i : ℂ)) *
            (Complex.exp (-Complex.I * (t : ℂ) * (f i : ℂ)) * v i)) := by
    rw [← h1, ContinuousLinearEquiv.symm_apply_apply]
  rw [hd]
  exact (((EuclideanSpace.equiv n ℂ).symm : (n → ℂ) →L[ℂ] EuclideanSpace ℂ n).restrictScalars
    ℝ).hasFDerivAt.comp_hasDerivAt t hg
